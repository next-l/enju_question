# -*- encoding: utf-8 -*-
class AnswersController < ApplicationController
  load_and_authorize_resource :except => :index
  authorize_resource :only => :index
  before_filter :store_location, :only => [:index, :show, :new, :edit]
  before_filter :get_user_if_nil, :except => [:edit]
  before_filter :get_question
  cache_sweeper :question_sweeper, :only => [:create, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    if !current_user.try(:has_role?, 'Librarian')
      if @question
        unless @question.try(:shared?)
          access_denied; return
        end
      end
      if @user
        if @user == current_user
          redirect_to answers_url(:format => params[:format])
          return
        else
          access_denied; return
        end
      end
    end

    @count = {}
    if user_signed_in?
      if current_user.has_role?('Librarian')
        if @question
          @answers = @question.answers.order('answers.id').page(params[:page])
        elsif @user
          @answers = @user.answers.order('answers.id').page(params[:page])
        else
          @answers = Answer.order('answers.id').page(params[:page])
        end
      else
        if @question
          if @question.user == current_user
            @answers = @question.answers.order('answers.id').page(params[:page])
          else
            @answers = @question.answers.public_answers.order('answers.id').page(params[:page])
          end
        elsif @user
          if @user == current_user
            @answers = @user.answers.order('answers.id').page(params[:page])
          else
            @answers = @user.answers.public_answers.order('answers.id').page(params[:page])
          end
        else
          @answers = Answer.public_answers.order('answers.id').page(params[:page])
        end
      end
    else
      if @question
        @answers = @question.answers.public_answers.order('answers.id').page(params[:page])
      else
        @answers = Answer.public_answers.order('answers.id').page(params[:page])
      end
    end
    @count[:query_result] = @answers.size

    respond_to do |format|
      format.html # index.rhtml
      format.json { render :json => @answers.to_json }
      format.rss  { render :layout => false }
      format.atom
    end
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    respond_to do |format|
      format.html # show.rhtml
      format.json { render :json => @answer.to_json }
    end
  end

  # GET /answers/new
  def new
    if @question
      @answer = current_user.answers.new
      @answer.question = @question
    else
      flash[:notice] = t('answer.specify_question')
      redirect_to questions_url
    end
  end

  # GET /answers/1;edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = current_user.answers.new(params[:answer])
    unless @answer.question
      redirect_to questions_url
      return
    end

    respond_to do |format|
      if @answer.save
        flash[:notice] = t('controller.successfully_created', :model => t('activerecord.models.answer'))
        format.html { redirect_to(@answer) }
        format.json { render :json => @answer, :status => :created, :location => answer_url(@answer) }
        format.mobile { redirect_to question_url(@answer.question) }
      else
        format.html { render :action => "new" }
        format.json { render :json => @answer.errors.to_json }
        format.mobile { render :action => "new" }
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        flash[:notice] = t('controller.successfully_updated', :model => t('activerecord.models.answer'))
        format.html { redirect_to(@answer) }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @answer.errors.to_json }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to question_answers_url(@answer.question) }
      format.json { head :ok }
    end
  end
end

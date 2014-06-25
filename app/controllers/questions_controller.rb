# -*- encoding: utf-8 -*-
class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :store_location, :only => [:index, :show, :new, :edit]
  before_action :get_user, :except => [:edit]
  after_action :verify_authorized

  # GET /questions
  # GET /questions.json
  def index
    authorize Question
    store_location
    if @user and user_signed_in?
      user = @user
    end
    c_user = current_user

    session[:params] = {} unless session[:params]
    session[:params][:question] = params

    @count = {}
    case params[:sort_by]
    when 'updated_at'
      sort_by = 'updated_at'
    when 'created_at'
      sort_by = 'created_at'
    when 'answers_count'
      sort_by = 'answers_count'
    else
      sort_by = 'updated_at'
    end

    case params[:solved]
    when 'true'
      solved = true
      @solved = solved.to_s
    when 'false'
      solved = false
      @solved = solved.to_s
    end

    if params[:query].to_s.strip == ''
      user_query = '*'
    else
      user_query = params[:query]
    end
    if user_signed_in?
      role_ids = Role.where('id <= ?', current_user.role.id).pluck(:id)
    else
      role_ids = [1]
    end

    query = {
      query: {
        filtered: {
          query: {
            query_string: {
              query: user_query, fields: ['_all']
            }
          }
        }
      },
      sort: {
      }
    }

    search.build do
      order_by sort_by, :desc
    end

    if user
      query[:query][:filtered].merge(
        filter: {
          term: {
            username: user.username
          }
        }
      )
    end

    if c_user != user
      unless c_user.has_role?('Librarian')
        query[:query][:filtered].merge(
          filter: {
            term: {
              shared: true
            }
          }
        )
      end
    end

    if @solved
      query[:query][:filtered].merge(
        filter: {
          term: {
            solved: true
          }
        }
      )
    end

    body = {
      facets: {
        solved: {
          terms: {
            field: :solved
          }
        }
      }
    }

    search = Question.search(query.merge(body), routing: role_ids)
    @questions = search.page(params[:page]).records
    @question_facet = search.response["facets"]["solved"]["terms"]
    @count[:query_result] = searcu.results.total

    if query.present?
      begin
        @crd_results = Question.search_crd(:query_01 => query, :page => params[:crd_page]).per(5)
      rescue Timeout::Error
        @crd_results = Kaminari::paginate_array([]).page(1)
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @questions }
      format.xml {
        if params[:mode] == 'crd'
          render :template => 'questions/index_crd'
          convert_charset
        else
          render :xml => @questions
        end
      }
      format.rss  { render :layout => false }
      format.atom
      format.js
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @question }
      format.xml {
        if params[:mode] == 'crd'
          render :template => 'questions/show_crd'
          convert_charset
        else
          render :xml => @question
        end
      }
    end
  end

  # GET /questions/new
  def new
    @question = Question.new
    authorize @question
    @question.user = current_user
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    authorize @question

    respond_to do |format|
      if @question.save
        flash[:notice] = t('controller.successfully_created', :model => t('activerecord.models.question'))
        format.html { redirect_to @question }
        format.json { render :json => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update_attributes(question_params)
        flash[:notice] = t('controller.successfully_updated', :model => t('activerecord.models.question'))
        format.html { redirect_to @question }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to user_questions_url(@question.user) }
      format.json { head :no_content }
    end
  end

  private
  def set_question
    @question = Question.find(params[:id])
    authorize @question
  end

  def question_params
    params.require(:question).permit(
      :body, :shared, :solved, :note
    )
  end
end

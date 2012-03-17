class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied, :with => :render_403
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  before_filter :set_locale

  private
  def render_403
    return if performed?
    if user_signed_in?
      respond_to do |format|
        format.html {render :template => 'page/403', :status => 403}
        format.mobile {render :template => 'page/403', :status => 403}
        format.xml {render :template => 'page/403', :status => 403}
        format.json
      end
    else
      respond_to do |format|
        format.html {redirect_to new_user_session_url}
        format.mobile {redirect_to new_user_session_url}
        format.xml {render :template => 'page/403', :status => 403}
        format.json
      end
    end
  end

  def render_404
    return if performed?
    respond_to do |format|
      format.html {render :template => 'page/404', :status => 404}
      format.mobile {render :template => 'page/404', :status => 404}
      format.xml {render :template => 'page/404', :status => 404}
      format.json
    end
  end

  def set_locale
    if params[:locale]
      unless I18n.available_locales.include?(params[:locale].to_s.intern)
        raise InvalidLocaleError
      end
    end
    if user_signed_in?
      locale = params[:locale] || session[:locale] || current_user.locale.try(:to_sym)
    else
      locale = params[:locale] || session[:locale]
    end
    if locale
      I18n.locale = @locale = session[:locale] = locale.to_sym
    else
      I18n.locale = @locale = session[:locale] = I18n.default_locale
    end
  rescue InvalidLocaleError
    @locale = I18n.default_locale
  end

  def not_found
    raise ActiveRecord::RecordNotFound
  end

  def access_denied
    raise CanCan::AccessDenied
  end

  def get_user
    @user = User.where(:username => params[:user_id]).first if params[:user_id]
  end

  def get_question
    @question = Question.find(params[:question_id]) if params[:question_id]
    authorize! :show, @question if @question
  end

  def convert_charset
    case params[:format]
    when 'csv'
      return unless configatron.csv_charset_conversion
      # TODO: 他の言語
      if @locale.to_sym == :ja
        headers["Content-Type"] = "text/csv; charset=Shift_JIS"
        response.body = NKF::nkf('-Ws', response.body)
      end
    when 'xml'
      if @locale.to_sym == :ja
        headers["Content-Type"] = "application/xml; charset=Shift_JIS"
        response.body = NKF::nkf('-Ws', response.body)
      end
    end
  end

  def store_location
    if request.get? and request.format.try(:html?) and !request.xhr?
      session[:user_return_to] = request.fullpath
    end
  end

  def solr_commit
    Sunspot.commit
  end
end

class InvalidLocaleError < StandardError
end

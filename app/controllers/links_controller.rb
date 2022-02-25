class LinksController < ApplicationController
  def index
    @links= Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    #@link.long_link = @link.sanitize
    if @link.save
      redirect_to links_path
    else
      flash[:error] = @link.errors.full_messages
      redirect_to new_link_path
    end

  end

  def show
    #@link = Link.find_by(short_link: params[:short_link])
    #redirect_to @link.sanitize
    @link = Link.find_by_slug(params[:slug])
    render 'errors/404', status: 404 if @link.nil?
    #@link.update_attribute(:clicked, @link.clicked + 1)
    redirect_to @link.url
  end

  private
  def link_params
    params.require(:link).permit(:url, :slug)
  end
end

class LinksController < ApplicationController
  def index
    @links= Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to links_path
    else
      flash[:error] = @link.errors.full_messages
      redirect_to new_link_path
    end

  end

  def show
    @link = Link.find_by_slug(params[:slug])
    if @link.nil?
      render 'errors/404', status: 404
    else
      redirect_to @link.url
    end
  end

  private
  def link_params
    params.require(:link).permit(:url, :slug)
  end
end

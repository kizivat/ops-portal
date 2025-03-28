class Cms::PagesController < ApplicationController
  # /:category_slug
  # /:page_slug
  # /:category_slug/:page_slug
  def index
    slugs = params[:cms_slugs].split("/")

    root_category = Cms::Category.root_cms

    if slugs.count == 2
      @category = Cms::Category.find_by(parent_category_id: root_category, slug: slugs.first)
      @page = load_page(@category, slugs.last)

      raise_not_found if @page.nil? || @category.nil?

      render "cms/pages/show"
    elsif slugs.count == 1
      @category = Cms::Category.find_by(parent_category_id: root_category, slug: slugs.first)
      @page = load_page(root_category, slugs.first)

      if @category
        @pages = load_pages(@category)
        render "cms/pages/index"
      elsif @page
        render "cms/pages/show"
      else
        raise_not_found
      end
    else
      raise_not_found
    end
  end

  private

  def load_pages(category)
    category.pages.published.order(created_at: :desc).page(params[:page]).per(12)
  end

  def load_page(category, slug)
    category.pages.published.find_by(slug: slug)
  end

  def raise_not_found
    raise ActionController::RoutingError.new("Not Found in Cms")
  end
end

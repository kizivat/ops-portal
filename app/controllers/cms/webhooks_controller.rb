class Cms::WebhooksController < ActionController::API
  def webhook
    if params[:post]
      # we care only about the first post
      if params[:post][:post_number] == 1
        Cms::ImportPageJob.perform_later(params[:post][:topic_id])
      end
    elsif params[:topic]
      Cms::ImportPageJob.perform_later(params[:topic][:id])
    elsif params[:category]
      category_ids = importing_category_ids
      # run import only for the category we are actually importing
      if category_ids.include?(params[:category][:id]) || category_ids.include?(params[:category][:parent_category_id])
        Cms::ImportCategoryJob.perform_later(params[:category][:id])
      end
    end
  end

  private

  def importing_category_ids
    ENV["DISCOURSE_IMPORT_CATEGORY_IDS"].split(",").map(&:to_i)
  end
end

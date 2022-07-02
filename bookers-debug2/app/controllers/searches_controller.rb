class SearchesController < ApplicationController
  before_action :authenticate_user!

  SEARCH_MODELS = {
    Book: {
      name: 'Book',
      view_label: 'books',
      column: 'title',
    },
    User: {
      name: 'User',
      view_label: 'users',
      column: 'name',
    },
  }

  SEARCH_TYPES = {
    Exact: {
      name: 'Exact',
      view_label: '完全一致',
    },
    Prefix: {
      name: 'Prefix',
      view_label: '前方一致',
    },
    Suffix: {
      name: 'Suffix',
      view_label: '後方一致',
    },
    Contains: {
      name: 'Contains',
      view_label: '部分一致',
    },
  }

  def search
    keyword = params[:keyword]
    target_model = params[:target_model]
    search_type = params[:search_type]

    render status: 400 unless SEARCH_MODELS.has_key?(target_model.to_sym)
    render status: 400 unless SEARCH_TYPES.has_key?(search_type.to_sym)

    case search_type
      when SEARCH_TYPES[:Prefix][:name]
        keyword = "#{keyword}%"
      when SEARCH_TYPES[:Suffix][:name]
        keyword = "%#{keyword}"
      when SEARCH_TYPES[:Contains][:name]
        keyword = "%#{keyword}%"
    end


    @objs = target_model.constantize.where(
      target_model.constantize.arel_table[
        SEARCH_MODELS[target_model.to_sym][:column].to_sym
      ].matches(keyword)
    )
    @target_model = target_model
    logger.debug([@objs, @target_model])
  end
end

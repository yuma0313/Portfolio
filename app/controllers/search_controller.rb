class SearchController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		@records = PostImage.search_for(@content, @method)
	end
end

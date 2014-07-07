class ArticlesController < ApplicationController
	include ArticlesHelper


	def index
		@search = Article.search(params[:q])
		if params[:tag]
		  @articles = @search.result.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 10)
		else
		  @articles = @search.result.paginate(page: params[:page], per_page: 10)
		end
	end
  
  def show
  	@article = Article.find(params[:id])
  	@comment = Comment.new
	@comment.article_id = @article.id
  end
  
  def new
  	@article = Article.new
  end
  
  def create
 		@article = Article.new(article_params)
	  @article.save
	  
	  flash.notice = "Congratulations! you created a new article named '#{@article.title}' !"
	  
	  redirect_to article_path(@article)
  end
  
  def destroy
  	@article = Article.find(params[:id])
  	@article.destroy
  	
  	flash.notice = "Successfully deleted the article named '#{@article.title}' !"
  	
  	redirect_to articles_path
  end
  
  def edit
  	@article = Article.find(params[:id])
	end
	
	def update
		@article = Article.find(params[:id])
		@article.update(article_params)
		
		flash.notice = "You just updated the article '#{@article.title}' !"
		
		redirect_to article_path(@article)
	end

end

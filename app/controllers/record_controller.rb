require './config/environment'


class RecordsController < ApplicationController
    # register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }



  get '/records/new' do #loads new form
    erb :new
  end

  get '/records' do #loads index page
    @records = record.all
    erb :index
  end

  get '/records/:id' do  #loads show page
    @record = record.find_by_id(params[:id])
    erb :show
  end

  get '/records/:id/edit' do #loads edit form
    @record = record.find_by_id(params[:id])
    erb :edit
  end

  patch '/records/:id' do  #updates a record
    @record = record.find_by_id(params[:id])
    @record.artist = params[:artist]
    @record.title = params[:title]
    @record.label = params[:label]
    @record.save
    redirect to "/records/#{@record.id}"
  end

  post '/records' do  #creates a record
    @record = record.create(params)
    redirect to "/records/#{@record.id}"
  end

  delete '/records/:id/delete' do #delete action
  @record = record.find_by_id(params[:id])
  @record.delete
  redirect to '/records'
end



end
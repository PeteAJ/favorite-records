require "./config/environment"
require "./app/models/record"

class RecordsController < ApplicationController
    # register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

 

  get '/records/new' do #loads new form
    erb :'/records/new'
  end

  get '/records' do #loads index page
    @records = Record.all
    erb :'/records/index'
  end

  get '/records/:id' do  #loads show page
    @record = Record.find_by_id(params[:id])
    erb :'/records/show'
  end

  get '/records/:id/edit' do #loads edit form
    @record = Record.find_by_id(params[:id])
    erb :'/records/edit'
  end

  patch '/records/:id' do  #updates a record
    @record = Record.find_by_id(params[:id])
    @record.artist = params[:artist]
    @record.title = params[:title]
    @record.label = params[:label]
    @record.save
    redirect to "/records/#{@record.id}"
  end

  post '/records' do  #creates a record
    @record = Record.create(params)
    redirect to "/records/#{@record.id}"
  end

  delete '/records/:id/delete' do #delete action
  @record = Record.find_by_id(params[:id])
  @record.delete
  redirect to '/records'
end



end
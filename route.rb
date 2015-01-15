require "rubygems"
require "sinatra"
require "sinatra/reloader"
require "data_mapper"

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/text.db")

class Blog
    include DataMapper::Resource
    property :id, Serial
    property :heading, String, :required => true
    property :content, Text, :required => true
    property :author, String, :required => true
    property :created_at, DateTime
    property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

get "/" do
    @blogs = Blog.all :order => :id.desc
    erb :home
end

get "/add" do
    erb :add
end

post "/add" do
    b = Blog.new
    b.heading = params[:heading]
    b.content = params[:content]
    b.author = params[:author]
    b.created_at = Time.now
    b.updated_at = Time.now
    b.save
    redirect "/"
end

get "/:id" do
   @post = Blog.get params[:id]
   erb :post
end

get "/:id/edit" do
    @edit = Blog.get params[:id]
    erb :edit
end

post "/:id/edit" do
    b = Blog.get params[:id]
    b.heading = params[:heading]
    b.content = params[:content]
    b.author = params[:author]
    b.updated_at = Time.now
    b.save
    redirect "/#{params[:id]}"
end

get "/:id/delete" do
    @delete = Blog.get params[:id]
    erb :delete
end

post "/:id/delete" do
    b = Blog.get params[:id]
    b.destroy
    redirect "/"
end








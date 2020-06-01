class FiguresController < ApplicationController
  
  get '/figures/new' do
    @titles=Title.all
    @landmarks=Landmark.all
    erb :'/figures/new'
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end
    @figure.save

    redirect '/figures'
  end
    
  get '/figures' do
    erb :"figures/index"
  end

  patch "/figures/:id" do
    figure = Figure.find(params[:id])
    figure.update(params[:figure])
    landmark=Landmark.find_or_create_by(params[:landmark])
    landmark.figure=figure
    landmark.save
    redirect "/figures/#{figure.id}"
  end

end

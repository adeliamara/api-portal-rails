class TopicsController < ApplicationController
  before_action :set_topic, only: %i[show update destroy]

  # GET /topics
  def index
    @topics = Topic.all
    formatted_topics = @topics.map { |topic| format_topic_data(topic) }
    render json: formatted_topics
  end

  # GET /topics/1
  def show
    render json: format_topic_data(@topic)
  end

  # POST /topics
  def create
    json_data = JSON.parse(request.body.read)

    author_data = json_data['author']
    author = Author.find_or_create_by(name: author_data['name'], city: author_data['city'])
    tag_names = json_data['tags'].map { |tag| tag['name'] }
    tags = tag_names.map { |tag_name| Tag.find_or_create_by(name: tag_name) }
    # Crie o tópico associado ao autor
    @topic = Topic.new(
      description: json_data['description'],
      active: json_data['active']
    )
    @topic.author = author

    @topic.tags = tags

    if @topic.save
      render json: format_topic_data(@topic), status: :created, location: @topic
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /topics/1
  def update
    if @topic.update(topic_params)
      render json: format_topic_data(@topic)
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # DELETE /topics/1
  def destroy
    @topic.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def topic_params
    params.require(:topic).permit(:description, :active)
  end

  def format_author_data(author)
    {
      id: author.id,
      name: author.name,
      city: author.city
    }
  end

  def format_topic_data(topic)
    {
      id: topic.id,
      description: topic.description,
      active: topic.active,
      author: format_author_data(topic.author),
      createdAt: topic.created_at,
      tags: topic.tags.map { |tag| { id: tag.id, name: tag.name } }
    }
  end
end

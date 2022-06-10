class GroundsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_ground, only: [:show, :join, :start, :leave, :score]

  def index

  end

  def show
    if @ground.users.exists?(current_user.id)
      @mcqs = [1,2,3,4,5,6,7,8,9,10] #Subject.where(name: @ground.prep).mcqs.order("RANDOM()").limit(10)
    end
  end

  def create
    @ground = Ground.new(ground_params)
    @ground.name = rand(36**3).to_s(36)+'-'+rand(36**4).to_s(36)+'-'+rand(36**3).to_s(36) #generates random name
    if @ground.save
      # params[:name] = @ground.name
      current_user.ground_players.where(ground_id: @ground.id, is_organizer: true).first_or_create
      redirect_to ground_url(@ground), notice: 'Ground created successfully.'
    else
      render 'new'
    end
  end

  def join
    if @ground.ground_players.count >= 5
      redirect_to ground_path(@ground), notice: 'Ground is full.'
    else
      current_user.ground_players.where(ground_id: @ground.id).first_or_create
      # broadcasting joining users
      ActionCable.server.broadcast "ground:#{@ground.name}:join", {action: 'joined', user: GroundsController.render(partial: 'user', locals: {user: current_user, ground: @ground}), user_id: current_user.id}
      redirect_to ground_url(@ground), notice: 'Joined ground successfully.'
    end
  end

  def start
    if current_user == @ground.organizer
      @ground.playing!
      ActionCable.server.broadcast "ground:#{@ground.name}:start", {action: 'started', user_id: current_user.id}
    end
  end

  def leave
    @ground.ground_players.where(user_id: current_user.id).delete_all
    if @ground.ground_players.count == 0
      ActionCable.server.broadcast "ground:#{@ground.name}:end", {action: 'ended', why: 'The game ended since nobody is playing.'}
      @ground.destroy
    else
      ActionCable.server.broadcast "ground:#{@ground.name}:leave", {action: 'left', user_id: current_user.id}
    end
    redirect_to grounds_url
  end

  def score
    ground_player = current_user.ground_players.where(ground_id: @ground.id).first
    ground_player.update_attribute(:score, ground_player.score+1) if params[:kind] == 'add'
    # broadcasting score to users
    ActionCable.server.broadcast "ground:#{@ground.name}:score", {action: 'scored', kind: params[:kind], score: ground_player.score, user_id: current_user.id}
  end

  private

  def find_ground
    @ground = Ground.find_by(name: params[:name])
    redirect_to grounds_path, notice: 'There is no such ground.' if @ground.blank?
  end

  def ground_params
    params.require(:ground).permit(:prep)
  end
end

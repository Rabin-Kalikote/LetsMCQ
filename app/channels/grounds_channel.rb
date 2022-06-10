class GroundsChannel < ApplicationCable::Channel
  def subscribed
    current_user.grounds.each do |ground|
      stream_from "ground:#{ground.name}:join"
      stream_from "ground:#{ground.name}:start"
      stream_from "ground:#{ground.name}:leave"
      stream_from "ground:#{ground.name}:end"
      stream_from "ground:#{ground.name}:score"
    end
    # stream_from "some_channel"
  end

  def unsubscribed
    # leave the ground
    current_ground = current_user.grounds.first
    current_ground.ground_players.where(user_id: current_user.id).delete_all
    if current_ground.ground_players.count == 0
      ActionCable.server.broadcast "ground:#{current_ground.name}:end", {action: 'ended', why: 'The game ended since nobody is playing.'}
      current_ground.destroy
    else
      ActionCable.server.broadcast "ground:#{current_ground.name}:leave", {action: 'left', user_id: current_user.id}
    end
    stop_all_streams
    # Any cleanup needed when channel is unsubscribed
  end
end

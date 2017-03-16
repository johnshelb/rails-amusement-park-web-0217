class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if user.tickets < attraction.tickets #no ride
      if user.height < attraction.min_height
        return "Sorry. You do not have enough tickets the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
      else
        return "Sorry. You do not have enough tickets the #{attraction.name}."
      end
    elsif
      user.height < attraction.min_height
      return "Sorry. You are not tall enough to ride the #{attraction.name}."
    else #taking the ride
      user.tickets -= attraction.tickets
      #binding.pry
      user.happiness += attraction.happiness_rating
      user.nausea += attraction.nausea_rating
    end
    user.save
  end


end

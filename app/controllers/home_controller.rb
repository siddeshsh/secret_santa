class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = [
      {
        title: "Handmade / Funny Santa",
        date: "December 18th",
        description: "Gift something you've made yourself or humorous or silly -  funny mug, prank item, a knitted scarf, homemade card, baked treat, or any creative item!",
        budget: "No budget constraint",
        icon: "🎨 / 😄",
        color: "handmade"
      },
      # {
      #   title: "Funny Santa",
      #   date: "December 19th",
      #   description: "Gift something humorous or silly - a funny mug, prank item, or quirky gadget to spread laughter!",
      #   budget: "Rs 100",
      #   icon: "😄",
      #   color: "funny"
      # },
      {
        title: "Secret Santa",
        date: "December 22nd",
        description: "The classic Secret Santa! Get randomly assigned a colleague and gift something thoughtful based on their preferences.",
        budget: "Rs 300",
        icon: "🎁",
        color: "secret"
      }
    ]

    @reminders = check_reminders
  end

  private

  def check_reminders
    today = Date.today
    reminders = []

    if today == Date.new(2024, 12, 18)
      reminders << { event: "Handmade / Funny Santa", message: "Don't forget to bring your handmade or a funny gift today!" }
    # elsif today == Date.new(2024, 12, 19)
    #   reminders << { event: "Funny Santa", message: "Time to share some laughs! Bring your funny gift today!" }
    elsif today == Date.new(2024, 12, 22)
      reminders << { event: "Secret Santa", message: "It's Secret Santa day! Bring your thoughtful gift!" }
    end

    # Reminder for upcoming events
    if today >= Date.new(2024, 12, 17) && today < Date.new(2024, 12, 18)
      reminders << { event: "Upcoming", message: "Handmade / Funny  Santa is coming up on December 18th!" }
    # elsif today >= Date.new(2024, 12, 18) && today < Date.new(2024, 12, 19)
    #   reminders << { event: "Upcoming", message: "Funny Santa is tomorrow, December 19th!" }
    elsif today >= Date.new(2024, 12, 19) && today < Date.new(2024, 12, 22)
      reminders << { event: "Upcoming", message: "Secret Santa is coming up on December 22nd!" }
    end

    reminders
  end
end

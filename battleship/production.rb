module Production
  
  attr_accessor :computer_players

#  # Define this method if you want the production name to be different from the default, directory name.
#  def name
#    return !-PRODUCTION_NAME-!
#  end
#
#  # Hook #1.  Called when the production is newly created, before any loading has been done.
#  # This is a good place to require needed files and instantiate objects in the busines layer.
  def production_opening
   $: << File.expand_path(File.dirname(__FILE__) + "/lib")
   $USE_SERVER = false
  end
#
#  # Hook #2.  Called after internal gems have been loaded and stages have been instantiated.
#  def production_loaded
#  end
#
#  # Hook #3.  Called when the production has fully opened.
#  def production_opened
#  end
#
#  # The system will call this methods when it wishes to close the production, perhaps when the user quits the
#  # application.  By default the production will always return true. You may override this behavior by re-implenting
#  # the methods here.
#  def allow_close?
#    return true
#  end
#
#  # Called when the production is about to be closed.
#  def production_closing
#  end
#
#  # Called when the production is fully closed.
#  def production_closed
#  end

end
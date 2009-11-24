module UserExtension::Echo
  def self.included(base)
    base.instance_eval do
      has_many :echo_details
      has_many :echos, :through => :echo_details
      has_many :echoed_statements, :through => :echo_details, :source => :statement
      
      include InstanceMethods
    end
  end

  module InstanceMethods
    # creates a new EchoDetail record with the given options or updates an existing EchoDetail if applicable
    def echo!(echoable, options={})
      ed = echo_details.create_or_update!(options.merge(:echo => echoable.find_or_create_echo))
      # OPTIMIZE: update the counters periodically
      ed.echo.update_counter! ; ed
    end
    
    # states that the +user+ visited the given +echoable+
    def visited!(echoable)
      echo!(echoable, :visited => true)
    end
    
    # states that the +user+ supported the given +echoable+
    def supported!(echoable)
      echo!(echoable, :supported => true)
    end
    
    # returns true if the +user+ has visted the given +echoable+
    def visited?(echoable)
      echoable.echo_details.visited.any?
    end
    
    # returns true if the +user+ has supported the given +echoable+
    def supported?(echoable)
      echoable.echo_details.supported.any?
    end
  end
end


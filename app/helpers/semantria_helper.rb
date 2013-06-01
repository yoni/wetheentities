require 'semantria'
module SemantriaHelper
  CONSUMER_KEY = ENV['SEMANTRIA_CONSUMER_KEY']
  CONSUMER_SECRET = ENV['SEMANTRIA_CONSUMER_SECRET']
  POLL_SECONDS = 2
  TIMEOUT_SECONDS = 120

  class SessionCallbackHandler < CallbackHandler
    def onRequest(sender, args)
      Rails.logger.info "Semantria Request: #{args}"
    end

    def onResponse(sender, args)
      Rails.logger.info "Semantria Response: #{args}"
    end

    def onError(sender, args)
      Rails.logger.info "Semantria Error: #{args}"
    end

    def onDocsAutoResponse(sender, args)
      Rails.logger.info "Semantria DocsAutoResponse: #{args.length}, #{args}"
    end

    def onCollsAutoResponse(sender, args)
      Rails.logger.info "Semantria CollsAutoResponse: #{args.length}, #{args}"
    end
  end

  def session
    # Initializes new session with the keys and app name.
    # We also will use compression.
    # Opening a new session for each request so that we don't have any concurrency issues. We might relax this
    # once we've got a stable release.
    session = Session.new(CONSUMER_KEY, CONSUMER_SECRET, 'WeTheEntities')
    # Initialize session callback handlers
    callback = SessionCallbackHandler.new()
    session.setCallbackHandler(callback)
    session
  end
  module_function :session

  def statistics
    session.getStatistics
  end

  %w(document collection).each do |name|
    class_eval <<EOF
      # Runs analysis on a single #{name}
      def enhance_#{name}(#{name})
        results = enhance_#{name.pluralize}([#{name}])
        results.empty? ? nil : results[0]
      end
      module_function :enhance_#{name}

      # Runs analysis on all #{name.pluralize} collectively
      def enhance_#{name.pluralize}(#{name.pluralize})
        Rails.logger.info "Loading Semantria analysis for #{name.pluralize}"
        session = session()

        # Check status from Semantria service
        #{name.pluralize}.each do |#{name}|
          # Queues #{name} for processing on Semantria service
          status = session.queue#{name.capitalize}(#{name})
          # Check status from Semantria service
          if status == 202
            Rails.logger.info "#{name.capitalize} \#{#{name}['id']} queued successfully."
          else
            raise "Error queueing #{name} \#{#{name}['id']}. Semantria API returned status: \#{status}"
          end
        end

        length = #{name.pluralize}.length
        results = []
        total_poll_time = 0
        while results.length < length
          # As Semantria isn't real-time solution you need to wait some time before getting of the processed results
          # In real application here can be implemented two separate jobs, one for queuing of source data another one for retrieving
          # Wait while Semantria process queued #{name}
          Rails.logger.info "Waiting #{POLL_SECONDS} sec between Semantria polling..."
          sleep(POLL_SECONDS)
          # Requests processed results from Semantria service
          status = session.getProcessed#{name.capitalize.pluralize}()
          # Check status from Semantria service
          status.is_a? Array and status.each do |object|
            results.push(object)
          end
          Rails.logger.info "\#{status.length} #{name.pluralize} received successfully."
          total_poll_time += POLL_SECONDS
          if total_poll_time > TIMEOUT_SECONDS
            Rails.logger.info "Reached timeout after polling for \#{total_poll_time} seconds. Returning results."
            return results
          end
        end

        results
      end
      module_function :enhance_#{name.pluralize}
EOF
  end
end


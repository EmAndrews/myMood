include Util

class DownloadController < ApplicationController

	# http://railscasts.com/episodes/362-exporting-csv-and-excel?view=asciicast

	def download
		print "download called\n"
    @messages = ProcessedMessages.all #ProcessedMessages.all  #Products.order(:name) ?
    respond_to do |format|
    	print "entered block\n"
      format.html
      print "format.html\n"
      mess = @messages.to_csv
      print "mess: ", mess, "\n"
      format.csv { send_data mess }
      print "sent\n"
    end
  end
  
  def my_csv (all_stuff)
  	print "my_csv"
  	CSV.generate do |csv|
		  csv << column_names
		  all_stuff.each do |product|
		    csv << user.attributes.values_at(*column_names)
		  end
		end
	end
end

include Util

class DownloadController < ApplicationController

	# http://railscasts.com/episodes/362-exporting-csv-and-excel?view=asciicast

	def download
		csv_file = ProcessedMessages.gen_csv()
		send_data csv_file, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=test.csv"

	end
end

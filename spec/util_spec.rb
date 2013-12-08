describe Util do
	describe 'convert to twilio number' do
		it 'should convert "222-333-4444" to "+12223334444"' do
			Util.convert_to_twilio_phone("222-333-4444").should == "+12223334444"
		end
		it 'should convert "+12223334444" to "+12223334444"' do
			Util.convert_to_twilio_phone("+12223334444").should == "+12223334444"
		end
	end
	
	describe 'convert to database number' do
		it 'should convert "+12223334444" to "222-333-4444"' do
			Util.convert_to_database_phone("+12223334444").should == "222-333-4444"
		end
		it 'should convert "2223334444" to "222-333-4444"' do
			Util.convert_to_database_phone("2223334444").should == "222-333-4444"
		end
	end
	
	describe 'week day prefix map' do
		it 'should return a map' do
			Util.week_day_prefix_map.should == {0 => "Su", 1 => "M", 2 => "Tu", 3 => "W", 4 => "Th", 5 => "F", 6 => "Sa" } 
		end
	end
end

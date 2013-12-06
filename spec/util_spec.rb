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
end

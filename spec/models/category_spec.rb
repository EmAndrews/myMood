describe Category do
  before do
    @cat = Category.create!( :name => 'Mood', :prefix => 'm')
    @message1 = MessageTemplate.create(:text => 'message1', :sequence_number => 1, :category => @cat)
    @message2 = MessageTemplate.create(:text => 'message2', :sequence_number => 2, :category => @cat)
  end

  describe 'update_seqs_by_removing' do
    it 'should update sequence numbers when removing a message' do
      @message2.sequence_number.should == 2
      @cat.update_seqs_by_removing @message1
      @message1.destroy
      @message2.reload
      @message2.sequence_number.should == 1
    end
  end
end

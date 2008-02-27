require File.dirname(__FILE__) + '/test_helper.rb'

include FltPnt

class TestArithmetic < Test::Unit::TestCase
  
  def setup
    @all_types = FltPnt.constants.map{|c| FltPnt.class_eval(c.to_s)}.select{|c| c.ancestors.include?(FltPnt::FormatBase)&& !(c.to_s.downcase.include?('format'))}
  end  

  def test_precision
    [BigDecimal,Rational].each do |at|
      FormatBase.arithmetic_type = at
      @all_types.each do |t|
        one = t.new('1')
        three = t.new('3')
        four = t.new('4')
        nine = t.new('9')
        ten = t.new('10')
        
        x = one - (four/three - one)*three
        
        check = t.splitted(x.sign,1,1-t.significand_digits)
        
        assert x==check, "#{t}: 1-(4/3-1)*3 = +/-#{t.radix}^#{1-t.significand_digits}"
        
      end
    end
  end
    
  def test_epsilon      
    [BigDecimal,Rational].each do |at|
      FormatBase.arithmetic_type = at
      @all_types.each do |t|      
        one = t.number(1)
        assert((one + t.epsilon)==one.next, "#{t}: 1+epsilon=1.next")
      end    
    end
  end  
    
end
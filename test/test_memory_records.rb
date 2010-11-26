require 'test/unit'

require File.expand_path('memory_record', File.dirname(__FILE__) + '/..')


class MemoryRecordTest < Test::Unit::TestCase


  def test_initialises
    testee = MemoryRecord.new(13445)
    assert_equal 13445, testee.memory
    assert_equal 13445, testee.peak
    assert_equal 13445, testee.trough

  end


  def test_does_not_prematurely_peak
    testee = MemoryRecord.new(1000)
    testee.memory=1001
    testee.memory=1002
    testee.memory=1003
    assert_equal 1000, testee.peak
    assert_equal 1003, testee.memory
  end


  def test_recognises_peak
    testee = MemoryRecord.new(1000)
    testee.memory=1001
    testee.memory=1002
    testee.memory=1001
    assert_equal 1002, testee.peak

  end

  def test_retains_peak_when_memory_descending
    testee = MemoryRecord.new(1000)
    testee.memory = 999
    testee.memory = 998
    assert_equal 1000, testee.peak 

    testee.memory = 999
    testee.memory = 998
    testee.memory = 997
    assert_equal 999, testee.peak
  end


  def test_recognises_flat_peak
    testee = MemoryRecord.new(1000)
    testee.memory = 1001
    testee.memory = 1002
    testee.memory = 1002
    testee.memory = 1001

    assert_equal 1002, testee.peak

  end

  def test_ledges_are_not_peaks
    testee = MemoryRecord.new(1000)
    testee.memory = 999
    testee.memory = 999
    testee.memory = 998
    testee.memory = 997
    assert_equal 1000, testee.peak 
    assert_equal 1000, testee.trough 
  end

  def test_ledges_are_not_troughs
    testee = MemoryRecord.new(1000)
    testee.memory = 999
    testee.memory = 999
    testee.memory = 998
    testee.memory = 997
    assert_equal 1000, testee.peak 
    assert_equal 1000, testee.trough 
  end


  def test_does_not_prematurely_trough
    testee = MemoryRecord.new(1000)
    testee.memory=999
    testee.memory=998
    testee.memory=997
    assert_equal 1000, testee.trough
    assert_equal 997, testee.memory
  end


  def test_recognises_trough
    testee = MemoryRecord.new(1000)
    testee.memory=999
    testee.memory=998
    testee.memory=999
    assert_equal 998, testee.trough

  end

  def test_retains_trough_when_memory_ascending
    testee = MemoryRecord.new(1000)
    testee.memory = 1001
    testee.memory = 1002
    assert_equal 1000, testee.trough 

    testee.memory = 1001
    testee.memory = 1002
    testee.memory = 1003
    assert_equal 1001, testee.trough
  end


  def test_recognises_flat_trough
    testee = MemoryRecord.new(1000)
    testee.memory = 999
    testee.memory = 998
    testee.memory = 998
    testee.memory = 999

    assert_equal 998, testee.trough

  end



end



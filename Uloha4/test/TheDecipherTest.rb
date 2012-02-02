require_relative '../lib/TheDecipherLibrary.rb'
require 'test/unit'


  #This class contains some tests for encryption / decryption
  class DecipherTest < Test::Unit::TestCase
  
    include Decipher
    
    #This method checks if a text can be encrypted and then decrypted correctly
    def test_encryption_reversibility()
      key = 7
      text = "abcdefghijklmnopqrstuvwxyz"
      assert_equal(text, decrypt(encrypt(text,key),key))
    end
    
    #This method checks if a text can be encrypted correctly
    def test_encrypt
      key = 7
      text = "abcd"
      assert_equal("hijk", encrypt(text, key))
    end
    
    #This method checks if a text can be decrypted correctly
    def test_decrypt
      key = 7
      text = "hijk"
      assert_equal("abcd", decrypt(text, key))
    end
  end
 

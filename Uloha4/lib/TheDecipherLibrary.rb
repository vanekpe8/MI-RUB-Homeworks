#This module contains methods for decryption / encryption
module Decipher
  public
  #this method encrypts given plainText, using given key
  def encrypt(plainText, key)
    shiftText(plainText, key)
  end
  
  #This mehtod decrypts given cipherText, using given key
  def decrypt(cipherText, key)
    shiftText(cipherText, key * (- 1))
  end
  
  private
  #this is private method used by both Decipher#encrypt and Decipher#decrypt methods.
  def shiftText(text, offset)
    result = ""
    text.length.times do |index|
      result += (text.getbyte(index) + offset).chr
    end
    result
  end
  
end

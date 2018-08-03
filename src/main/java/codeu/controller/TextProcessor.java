package codeu.controller;
package org.kefirsf.bb;

 public interface TextProcessor 
{
	 public CharSequence process(CharSequence source);
    public String process(String source);
    public StringBuilder process(StringBuilder source);
    public StringBuffer process(StringBuffer source);
}
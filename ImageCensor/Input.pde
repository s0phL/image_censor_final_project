import javax.swing.JOptionPane;

public static class input {
  
  static String prompt(String s) {
     println(s);
     String entry = JOptionPane.showInputDialog(s);
     if (entry == null) { //exits if user presses cancel
       System.exit(0);
       //return prompt(s);
     }
     //println(entry);
     return entry;
  }
  
  static String getString(String s) {
     return prompt(s);
  }

}

import javax.swing.JOptionPane;

public static class input {
  
  static String prompt(String s) {
     println(s);
     String entry = JOptionPane.showInputDialog(s);
     if (entry == null) { // to prevent user from cancelling out of input box
        return prompt(s);
     }
     //println(entry);
     return entry;
  }
  
  static String getString(String s) {
     return prompt(s);
  }

}

import javax.swing.JOptionPane;

public static class input {
  
  /* shows a dialog box for user to input information */
  static String prompt(String s) {
     println(s);
     String entry = JOptionPane.showInputDialog(s);
     if (entry == null) { // to prevent user from cancelling out of input box
        //return prompt(s);
     }
     return entry;
  }
  
  static String getString(String s) {
     return prompt(s);
  }

}

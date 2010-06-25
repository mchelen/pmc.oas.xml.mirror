<?php
/*
 * Display requested PMC file
 */
  
// root directory where .nxml files are stored
$filepath = "files";

// check if pmc id has been specified
if(isset($_GET['pmcid'])) {
  // get user input
  preg_match('/[0-9]+/', $_GET["pmcid"],$matches);
  $pmc = $matches[0];
  // generate list files command
  $cmd = "ls $filepath/*/*-$pmc.nxml";
  // run command and save results (trim whitespace)
  $output = trim(shell_exec($cmd));
  if (strlen($output)>0) {
    // set http header type
    header ("Content-Type:text/xml");
    // output requested file
    readfile($output);
  }
  else {
    print "PMC ID not found: \"$pmc\" \n";
  }
}
else {
  readfile("form.html");
}
?>

mydir <- "/Mac2/Images/Pollen_grains/Images/this/"  # set dir to where zvi files are
files <- dir(mydir) # list files
for(j in 1:length(files)){  
  system(
    paste("./JavaApplicationStub ", mydir, files[j], " -batch zmacro", sep=''),
    )
}


// count pollen grains - black/whtie pictures
macro "CountBWPollenGrains [z]" {
  title = getTitle;
  dir = "/Mac2/Images/Pollen_grains/Images/";
  run("Subtract Background...", "rolling=100");
  run("Invert");
  setAutoThreshold("Yen");
  run("Convert to Mask");
  run("Watershed");
  run("Analyze Particles...", "size=40-120 circularity=0.5-1.00 show=Masks summarize");
  saveAs("Measurements", dir + title + ".txt");
  run("Close");
}
# require(R.utils)
# 
# ## function that can take a long time
# fn1 <- function(x)
# {
# 	for (i in 1:x^x)
# 	{
# 		rep(x, 1000)
# 	}
# 	return("finished")
# }
# 
# ## test timeout
# evalWithTimeout(fn1(1), timeout = 1, onTimeout = "asdf") # should be fine
# evalWithTimeout(fn1(8), timeout = 1, onTimeout = "silent") # should timeout



sapply(df[6,2], function(x) oaih_identify(x)$repositoryName)

attachname <- function(x) {
	tt <- try(content(GET(paste("http://digitalcommons.wustl.edu/cgi/oai2.cgi", "?verb=Identify", sep=""), config = timeout(6))))
	if(class(tt)[[1]] == "try-error"){ NULL } else
		{ xmlToList(tt$doc$children[[1]])$Identify$repositoryName }
}
attachname(x=df[6,2])


foo <- function() {
	print("Tic");
	for (kk in 1:100) {
		print(kk);
		Sys.sleep(0.1);
	}
	print("Tac");
}

res <- evalWithTimeout({
	foo();
}, timeout=1.08, onTimeout="error");

evalWithTimeout( 
	oaih_identify(df[4,2])$repositoryName, 
								 timeout = 1, onTimeout = "silent")





setSessionTimeLimit(cpu=1, transient=T)
oaih_identify(df[4,2])$repositoryName


timeout <- 
function(expr, seconds = 60)
{
	# Set up a background process that will send a signal
	# to the current R process after 'seconds' seconds.
	# Evaluate expr with an interrupt handler installed
	# to catch the interrupt.
	# If expr finishes before that time it will kill the killer.
	killer.pid <- system(intern = TRUE, paste(" (sleep", seconds,
																						" ; kill -INT", Sys.getpid(),
																						")>/dev/null&\n echo $!"))
	on.exit(system(paste("kill", killer.pid, "> /dev/null 2>&1")))
	withCallingHandlers(expr, interrupt=function(...)stop("Timed
out", call.=FALSE))
}

Try it on Linux with
try(silent=TRUE, timeout(oaih_identify(df[1,2])$repositoryName, seconds=5))
Hit me: 34
> z
[1] "34"
> z <- try(silent=TRUE, timeout(readline(prompt="Hit me: "),
																seconds=5))
Hit me: > z
[1] "Error : Timed out\n"
attr(,"class")
[1] "try-error"
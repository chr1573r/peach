cat <<-EOF > pweb.html
<html>
<head>
    <title>peach result for $app</title>
    <style>
    body {
        background-color: #19282F;
    }

    pre {
        color: FCE5CD;
    }

    #result-success {
        color: #91EF91;
    }
    #result-failure {
        color: #AD111E;
    }
    #result-timeout {
        color: #F75C36;
    }

    #commitlog {
        color: rgb(136,96,97);
    }

    a {
        color: gray;
        text-decoration: none;
    }

    a:hover {
        color: #F9A33E;
    }
    </style>
    </head>
    <body>
    <pre><div style="color: #FAAB5C;">
                                         oooo
                                          888
oo.ooooo.   .ooooo.   .oooo.    .ooooo.   888 .oo.
 888   88b d88   88b  P  )88b  d88   "Y8  888P"Y88b
 888   888 888ooo888  .oP"888  888        888   888
 888   888 888    .o d8(  888  888   .o8  888   888
 888bod8P   Y8bod8P   Y888""8o  Y8bod8P  o888o o888o
 888
o888o           <span style="color: rgb(254,213,48)">// result viewer //</span>
</div>
<h1>$app testing resulted in <span id="result-$(cat "$app_result_dir/pch_result.txt")">$(cat "$app_result_dir/pch_result.txt")</span></h2>@ $(cat "$app_result_dir/pch_lastrun.txt")
<h2>stdout</h2><pre id="commitlog">$(cat "$app_result_dir/pch_stdout.txt")</pre>
<h2>stderr</h2><pre id="commitlog">$(cat "$app_result_dir/pch_stderr.txt")</pre>
</pre>
</div>
</body>
</html>

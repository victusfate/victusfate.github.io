function show(text, target) {
    var out = $('#' + target);
    out.hide();
//    out.html(out.html()+'<br/>'+text);
    out.html(text);
    out.fadeIn();
}

function GetMyRepos(uname) {
	var github_repo_api = "http://github.com/api/v2/json/repos/show/"+uname+"?callback=?";
	show("GetMyRepos apiurl " + github_repo_api, 'info-console');
	$.getJSON(github_repo_api, function(ob) {
		var repositories = ob.repositories;
		var names=[],urls=[];
		$(repositories).each(function(index) {
			if (this['master_branch'] == "gh-pages") {
				var s = this['homepage'];
				if (!s.match(/^[a-zA-Z]+:\/\//)) {
				    s = 'http://' + s;
				}				
				$('#repos').append('<div id="repo"><a href="'+s+'">'+this['name']+'</a></div>');
			}
			else {
				if (this['fork'] !== true) {
					names.push(this['name']);
					urls.push(this['url']);
				}
			}
		});
		$(names).each(function(i) {
			$('#repos_nopages').append('<div id="repo"><a href="'+urls[i]+'">'+names[i]+'</a></div>');
		});
		
		return ob;
	});
/*	
	$.ajax({
		url: "https://github.com/api/v2/json/repos/show/"+uname+"?callback=?",
		context: document.body,
		success: function(){
	    	alert("bump bump baaah "+ ob.toString());			
		}
	});
	*/
}
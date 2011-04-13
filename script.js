function show(text, target) {
    var out = $('#' + target);
    out.hide();
    out.html(text);
    out.fadeIn();
}

function GetMyRepos(uname)
	var github_repo_api = "https://github.com/api/v2/json/repos/show/"+uname+"&callback=?";
	show("GetMatchingStatuses apiurl " + twitterapiurl, 'info-console');
	$.getJSON(github_repo_api, function(ob) {
	    show("bump bump baaah "+ ob.toString());
	});
}
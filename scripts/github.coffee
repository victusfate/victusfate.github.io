show = (text, target) ->
    out = $("#" + target)
    out.hide()
    out.html text
    out.fadeIn()
    
# https://api.github.com/users/victusfate/repos

UrlForPage = (uname,pageNumber) ->
    "https://api.github.com/users/" + uname + "/repos?per_page=100&page=" + pageNumber + "&callback=?"

GetMyRepos = (uname) ->
    morePages = true
    page = 1
    getAnotherPage = (page) ->
        github_repo_api = UrlForPage(uname,page)
        console.log "url #{github_repo_api}"
        $.getJSON github_repo_api, (ob) ->
            page++;
            repos = ob.data
            console.log "repos #{repos}"
            morePages = false if repos.length == 0 || !Array.isArray repos
            names = []
            urls = []
            descs = []
            $(repos).each (index) ->
                console.log "index " + index + " repo " + this.name
                if this["fork"] != true
                    if this["default_branch"] == "gh-pages"
                        s = this["homepage"]
                        s = "http://" + s   unless s and s.match(/^[a-zA-Z]+:\/\//)
                        $("#repos").append '<div id="repo"><a href="' + s + '">' + this["name"] + '</a>:  ' + this["description"] + '</div>'
                    else
                        names.push this["name"]
                        urls.push this["html_url"]
                        descs.push this["description"]

            $(names).each (i) ->
                $("#repos_nopages").append '<div id="repo"><a href="' + urls[i] + '">' + names[i] + '</a>:  ' + descs[i] + '</div>'
            getAnotherPage(page) if morePages
    
    getAnotherPage(page)   

window.GetMyRepos = GetMyRepos

SearchRepos = (key,language="") ->
    langstr = ""
    langstr = "?language="+language if language
    github_repo_api = "https://api.github.com/legacy/repos/search/" + key + langstr + "?callback=?"
    console.log "GetMyRepos apiurl " + github_repo_api
    $.getJSON github_repo_api, (ob) ->
        repos = ob.data.repositories
        names = []
        urls = []
        descs = []
        dates = []
        $(repos).each (index) ->
            if this["fork"] != true
                names.push this["name"]
                urls.push this["html_url"]
                descs.push this["description"]
                dates.push this["created"]

#       $("#repos_nopages").append '<table cellpadding="0" cellspacing="0">'
        $(names).each (i) ->
#           $("#repos_nopages").append '<tr><td class="ghnum">' + i + '</td><td id="repo"><a href="' + urls[i] + '">' + names[i] + '</a> '+descs[i]+' <span style="color:#0086B3;">'+dates[i]+'</span></td></tr>'
            $("#repos_nopages").append '<div id="repo"><a href="' + urls[i] + '"' + 'color="#0086B3">' + names[i] + '</a> '+descs[i]+' <span style="color:#0086B3;">'+dates[i]+'</span></div>'
#       $("#repos_nopages").append '</table>'

        ob
window.SearchRepos = SearchRepos

  
  

  


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
        <title>newlib-xomb/newlib/libc/sys/xomb/crt0.c at a4c1c1d1f64aca2091f6748a11d97ba98bb3da95 from wilkie's buildtools - GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="http://github.com/fluidicon.png" title="GitHub" />

    <link href="http://assets3.github.com/stylesheets/bundle_common.css?61a0c4b07053d81e8bf8dca46007523a0a8e6000" media="screen" rel="stylesheet" type="text/css" />
<link href="http://assets2.github.com/stylesheets/bundle_github.css?61a0c4b07053d81e8bf8dca46007523a0a8e6000" media="screen" rel="stylesheet" type="text/css" />

    <script type="text/javascript" charset="utf-8">
      var GitHub = {}
      var github_user = null
      
    </script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js" type="text/javascript"></script>
    <script src="http://assets1.github.com/javascripts/bundle_common.js?61a0c4b07053d81e8bf8dca46007523a0a8e6000" type="text/javascript"></script>
<script src="http://assets2.github.com/javascripts/bundle_github.js?61a0c4b07053d81e8bf8dca46007523a0a8e6000" type="text/javascript"></script>

        <script type="text/javascript" charset="utf-8">
      GitHub.spy({
        repo: "wilkie/buildtools"
      })
    </script>

    
  
    
  

  <link href="http://github.com/wilkie/buildtools/commits/a4c1c1d1f64aca2091f6748a11d97ba98bb3da95.atom" rel="alternate" title="Recent Commits to buildtools:a4c1c1d1f64aca2091f6748a11d97ba98bb3da95" type="application/atom+xml" />

    <META NAME="ROBOTS" CONTENT="NOINDEX, FOLLOW">    <meta name="description" content="Some scripts to build buildtools." />
    <script type="text/javascript">
      GitHub.nameWithOwner = GitHub.nameWithOwner || "wilkie/buildtools";
      GitHub.currentRef = "";
    </script>
  

            <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-3769691-2']);
      _gaq.push(['_trackPageview']);
      (function() {
        var ga = document.createElement('script');
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        ga.setAttribute('async', 'true');
        document.documentElement.firstChild.appendChild(ga);
      })();
    </script>

  </head>

  

  <body>
    
    

    

    <div class="subnavd" id="main">
      <div id="header" class="pageheaded">
        <div class="site">
          <div class="logo">
            <a href="http://github.com"><img src="/images/modules/header/logov3.png" alt="github" /></a>
          </div>
          
          <div class="topsearch">
  
    <form action="/search" id="top_search_form" method="get">
      <a href="/search" class="advanced-search tooltipped downwards" title="Advanced Search">Advanced Search</a>
      <input type="search" class="search my_repos_autocompleter" name="q" results="5" placeholder="Search&hellip;" /> <input type="submit" value="Search" class="button" />
      <input type="hidden" name="type" value="Everything" />
      <input type="hidden" name="repo" value="" />
      <input type="hidden" name="langOverride" value="" />
      <input type="hidden" name="start_value" value="1" />
    </form>
  
  
    <ul class="nav logged_out">
      
        <li><a href="http://github.com">Home</a></li>
        <li class="pricing"><a href="/plans">Pricing and Signup</a></li>
        <li><a href="http://github.com/explore">Explore GitHub</a></li>
        
        <li><a href="/blog">Blog</a></li>
      
      <li><a href="https://github.com/login">Login</a></li>
    </ul>
  
</div>

        </div>
      </div>

      
      
        
    <div class="site">
      <div class="pagehead repohead vis-public   ">
        <h1>
          <a href="/wilkie">wilkie</a> / <strong><a href="http://github.com/wilkie/buildtools">buildtools</a></strong>
          
          
        </h1>

        
    <ul class="actions">
      

      
        <li class="for-owner" style="display:none"><a href="https://github.com/wilkie/buildtools/edit" class="minibutton btn-admin "><span><span class="icon"></span>Admin</span></a></li>
        <li>
          <a href="/wilkie/buildtools/toggle_watch" class="minibutton btn-watch " id="watch_button" style="display:none"><span><span class="icon"></span>Watch</span></a>
          <a href="/wilkie/buildtools/toggle_watch" class="minibutton btn-watch " id="unwatch_button" style="display:none"><span><span class="icon"></span>Unwatch</span></a>
        </li>
        
          <li class="for-notforked" style="display:none"><a href="/wilkie/buildtools/fork" class="minibutton btn-fork " id="fork_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'ed433012db2352fe8469b1a4e9fd90279a8aff8e'); f.appendChild(s);f.submit();return false;"><span><span class="icon"></span>Fork</span></a></li>
          <li class="for-hasfork" style="display:none"><a href="#" class="minibutton btn-fork " id="your_fork_button"><span><span class="icon"></span>Your Fork</span></a></li>
          <li id="pull_request_item" style="display:none"><a href="/wilkie/buildtools/pull_request/" class="minibutton btn-pull-request "><span><span class="icon"></span>Pull Request</span></a></li>
          <li><a href="#" class="minibutton btn-download " id="download_button"><span><span class="icon"></span>Download Source</span></a></li>
        
      
      <li class="repostats">
        <ul class="repo-stats">
          <li class="watchers"><a href="/wilkie/buildtools/watchers" title="Watchers" class="tooltipped downwards">1</a></li>
          <li class="forks"><a href="/wilkie/buildtools/network" title="Forks" class="tooltipped downwards">1</a></li>
        </ul>
      </li>
    </ul>


        <ul class="tabs">
  <li><a href="http://github.com/wilkie/buildtools/tree/" class="selected" highlight="repo_source">Source</a></li>
  <li><a href="http://github.com/wilkie/buildtools/commits/" highlight="repo_commits">Commits</a></li>

  
  <li><a href="/wilkie/buildtools/network" highlight="repo_network">Network (1)</a></li>

  

  
    
    <li><a href="/wilkie/buildtools/issues" highlight="issues">Issues (0)</a></li>
  

  
    
    <li><a href="/wilkie/buildtools/downloads">Downloads (0)</a></li>
  

  
    
    <li><a href="http://wiki.github.com/wilkie/buildtools/">Wiki (1)</a></li>
  

  <li><a href="/wilkie/buildtools/graphs" highlight="repo_graphs">Graphs</a></li>

  <li class="contextswitch nochoices">
    <span class="toggle leftwards tooltipped" title="a4c1c1d1f64aca2091f6748a11d97ba98bb3da95">
      <em>Tree:</em>
      <code>a4c1c1d</code>
    </span>
  </li>
</ul>

<div style="display:none" id="pl-description"><p><em class="placeholder">click here to add a description</em></p></div>
<div style="display:none" id="pl-homepage"><p><em class="placeholder">click here to add a homepage</em></p></div>

<div class="subnav-bar">
  
  <ul>
    <li>
      <a href="#" class="dropdown">Switch Branches (1)</a>
      <ul>
        
          
          
            <li><a href="/wilkie/buildtools/blob/master/newlib-xomb/newlib/libc/sys/xomb/crt0.c" action="show">master</a></li>
          
        
      </ul>
    </li>
    <li>
      <a href="#" class="dropdown defunct">Switch Tags (0)</a>
      
    </li>
    <li>
    
    <a href="/wilkie/buildtools/branches/master" class="manage">Branch List</a>
    
    </li>
  </ul>
</div>









        
    <div id="repo_details" class="metabox clearfix ">
      <div id="repo_details_loader" class="metabox-loader" style="display:none">Sending Request&hellip;</div>

      

      <div id="repository_description" rel="repository_description_edit">
        
          <p>Some scripts to build buildtools.
            <span id="read_more" style="display:none">&mdash; <a href="#readme">Read more</a></span>
          </p>
        
      </div>
      <div id="repository_description_edit" style="display:none;" class="inline-edit">
        <form action="/wilkie/buildtools/edit/update" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="ed433012db2352fe8469b1a4e9fd90279a8aff8e" /></div>
          <input type="hidden" name="field" value="repository_description">
          <input type="text" class="textfield" name="value" value="Some scripts to build buildtools.">
          <div class="form-actions">
            <button class="minibutton"><span>Save</span></button> &nbsp; <a href="#" class="cancel">Cancel</a>
          </div>
        </form>
      </div>

      
      <div class="repository-homepage" id="repository_homepage" rel="repository_homepage_edit">
        <p><a href="http://" rel="nofollow"></a></p>
      </div>
      <div id="repository_homepage_edit" style="display:none;" class="inline-edit">
        <form action="/wilkie/buildtools/edit/update" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="ed433012db2352fe8469b1a4e9fd90279a8aff8e" /></div>
          <input type="hidden" name="field" value="repository_homepage">
          <input type="text" class="textfield" name="value" value="">
          <div class="form-actions">
            <button class="minibutton"><span>Save</span></button> &nbsp; <a href="#" class="cancel">Cancel</a>
          </div>
        </form>
      </div>

      <div class="rule "></div>

      <div id="url_box" class="url-box">
        <ul class="clone-urls">
          <li id="private_clone_url" style="display:none"><a href="git@github.com:wilkie/buildtools.git" data-permissions="Read+Write">Private</a></li>
          
            <li id="public_clone_url"><a href="git://github.com/wilkie/buildtools.git" data-permissions="Read-Only">Read-Only</a></li>
            <li id="http_clone_url"><a href="http://github.com/wilkie/buildtools.git" data-permissions="Read-Only">HTTP Read-Only</a></li>
          
        </ul>
        <input type="text" spellcheck="false" id="url_field" class="url-field" />
              <span style="display:none" id="url_box_clippy"></span>
      <span id="clippy_tooltip_url_box_clippy" class="clippy-tooltip tooltipped" title="copy to clipboard">
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="14"
              height="14"
              class="clippy"
              id="clippy" >
      <param name="movie" value="/flash/clippy.swf?v5"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="id=url_box_clippy&amp;copied=&amp;copyto=">
      <param name="bgcolor" value="#FFFFFF">
      <param name="wmode" value="opaque">
      <embed src="/flash/clippy.swf?v5"
             width="14"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="id=url_box_clippy&amp;copied=&amp;copyto="
             bgcolor="#FFFFFF"
             wmode="opaque"
      />
      </object>
      </span>

        <p id="url_description">This URL has <strong>Read+Write</strong> access</p>
      </div>
    </div>


        

      </div><!-- /.pagehead -->

      









<script type="text/javascript">
  GitHub.currentCommitRef = "a4c1c1d1f64aca2091f6748a11d97ba98bb3da95"
  GitHub.currentRepoOwner = "wilkie"
  GitHub.currentRepo = "buildtools"
  GitHub.downloadRepo = '/wilkie/buildtools/archives/a4c1c1d1f64aca2091f6748a11d97ba98bb3da95'

  

  
</script>










  <div id="commit">
    <div class="group">
        
  <div class="envelope commit">
    <div class="human">
      
        <div class="message"><pre><a href="/wilkie/buildtools/commit/a4c1c1d1f64aca2091f6748a11d97ba98bb3da95">Oops. Stupid tar shit.</a> </pre></div>
      

      <div class="actor">
        <div class="gravatar">
          
          <img alt="" height="30" src="http://www.gravatar.com/avatar/45cf72d0b5611b4372b8367759882b93?s=30&amp;d=http%3A%2F%2Fgithub.com%2Fimages%2Fgravatars%2Fgravatar-30.png" width="30" />
        </div>
        <div class="name"><a href="/wilkie">wilkie</a> <span>(author)</span></div>
        <div class="date">
          <abbr class="relatize" title="2010-04-03 14:44:58">Sat Apr 03 14:44:58 -0700 2010</abbr>
        </div>
      </div>

      

    </div>
    <div class="machine">
      <span>c</span>ommit&nbsp;&nbsp;<a href="/wilkie/buildtools/commit/a4c1c1d1f64aca2091f6748a11d97ba98bb3da95" hotkey="c">a4c1c1d1f64aca2091f6748a11d97ba98bb3da95</a><br />
      <span>t</span>ree&nbsp;&nbsp;&nbsp;&nbsp;<a href="/wilkie/buildtools/tree/a4c1c1d1f64aca2091f6748a11d97ba98bb3da95/newlib-xomb/newlib/libc/sys/xomb/Makefile.am" hotkey="t">9af2cf80ec413358f1753984d3a120bff407e2a8</a><br />
      
        <span>p</span>arent&nbsp;
        
        <a href="/wilkie/buildtools/commit/09f54ff7be1f9e099ec3c2681c89dce8abda2580" hotkey="p">09f54ff7be1f9e099ec3c2681c89dce8abda2580</a>
      

    </div>
  </div>

    </div>
  </div>



  
    <div id="path">
      <b><a href="/wilkie/buildtools/tree/master">buildtools</a></b> / <a href="/wilkie/buildtools/tree/master/newlib-xomb">newlib-xomb</a> / <a href="/wilkie/buildtools/tree/master/newlib-xomb/newlib">newlib</a> / <a href="/wilkie/buildtools/tree/master/newlib-xomb/newlib/libc">libc</a> / <a href="/wilkie/buildtools/tree/master/newlib-xomb/newlib/libc/sys">sys</a> / <a href="/wilkie/buildtools/tree/master/newlib-xomb/newlib/libc/sys/xomb">xomb</a> / crt0.c       <span style="display:none" id="clippy_4276">newlib-xomb/newlib/libc/sys/xomb/crt0.c</span>
      
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="110"
              height="14"
              class="clippy"
              id="clippy" >
      <param name="movie" value="/flash/clippy.swf?v5"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="id=clippy_4276&amp;copied=copied!&amp;copyto=copy to clipboard">
      <param name="bgcolor" value="#FFFFFF">
      <param name="wmode" value="opaque">
      <embed src="/flash/clippy.swf?v5"
             width="110"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="id=clippy_4276&amp;copied=copied!&amp;copyto=copy to clipboard"
             bgcolor="#FFFFFF"
             wmode="opaque"
      />
      </object>
      

    </div>

    <div id="files">
      <div class="file">
        <div class="meta">
          <div class="info">
            <span class="icon"><img alt="Txt" height="16" src="http://assets2.github.com/images/icons/txt.png?61a0c4b07053d81e8bf8dca46007523a0a8e6000" width="16" /></span>
            <span class="mode" title="File Mode">100644</span>
            
              <span>24 lines (14 sloc)</span>
            
            <span>0.358 kb</span>
          </div>
          <ul class="actions">
            
              <li><a id="file-edit-link" href="#" rel="/wilkie/buildtools/file-edit/__ref__/newlib-xomb/newlib/libc/sys/xomb/crt0.c">edit</a></li>
            
            <li><a href="/wilkie/buildtools/raw/master/newlib-xomb/newlib/libc/sys/xomb/crt0.c" id="raw-url">raw</a></li>
            
              <li><a href="/wilkie/buildtools/blame/master/newlib-xomb/newlib/libc/sys/xomb/crt0.c">blame</a></li>
            
            <li><a href="/wilkie/buildtools/commits/master/newlib-xomb/newlib/libc/sys/xomb/crt0.c">history</a></li>
          </ul>
        </div>
        
  <div class="data syntax type-c">
    
      <table cellpadding="0" cellspacing="0">
        <tr>
          <td>
            
            <pre class="line_numbers">
<span id="LID1" rel="#L1">1</span>
<span id="LID2" rel="#L2">2</span>
<span id="LID3" rel="#L3">3</span>
<span id="LID4" rel="#L4">4</span>
<span id="LID5" rel="#L5">5</span>
<span id="LID6" rel="#L6">6</span>
<span id="LID7" rel="#L7">7</span>
<span id="LID8" rel="#L8">8</span>
<span id="LID9" rel="#L9">9</span>
<span id="LID10" rel="#L10">10</span>
<span id="LID11" rel="#L11">11</span>
<span id="LID12" rel="#L12">12</span>
<span id="LID13" rel="#L13">13</span>
<span id="LID14" rel="#L14">14</span>
<span id="LID15" rel="#L15">15</span>
<span id="LID16" rel="#L16">16</span>
<span id="LID17" rel="#L17">17</span>
<span id="LID18" rel="#L18">18</span>
<span id="LID19" rel="#L19">19</span>
<span id="LID20" rel="#L20">20</span>
<span id="LID21" rel="#L21">21</span>
<span id="LID22" rel="#L22">22</span>
<span id="LID23" rel="#L23">23</span>
<span id="LID24" rel="#L24">24</span>
</pre>
          </td>
          <td width="100%">
            
              <div class="highlight"><pre><div class="line" id="LC1"><span class="k">extern</span> <span class="kt">int</span> <span class="n">main</span><span class="p">(</span><span class="kt">int</span> <span class="n">argc</span><span class="p">,</span> <span class="kt">char</span> <span class="o">**</span><span class="n">argv</span><span class="p">,</span> <span class="kt">char</span> <span class="o">**</span><span class="n">environ</span><span class="p">);</span></div><div class="line" id="LC2"><br/></div><div class="line" id="LC3"><span class="k">extern</span> <span class="kt">char</span> <span class="n">__bss_start</span><span class="p">,</span> <span class="n">_end</span><span class="p">;</span> <span class="c1">// BSS should be the last think before _end</span></div><div class="line" id="LC4"><br/></div><div class="line" id="LC5"><span class="c1">// XXX: environment</span></div><div class="line" id="LC6"><span class="kt">char</span> <span class="o">*</span><span class="n">__env</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="o">=</span> <span class="p">{</span> <span class="mi">0</span> <span class="p">};</span></div><div class="line" id="LC7"><span class="kt">char</span> <span class="o">**</span><span class="n">environ</span> <span class="o">=</span> <span class="n">__env</span><span class="p">;</span></div><div class="line" id="LC8"><br/></div><div class="line" id="LC9"><span class="n">_start</span><span class="p">(){</span></div><div class="line" id="LC10">&nbsp;&nbsp;<span class="kt">char</span> <span class="o">*</span><span class="n">i</span><span class="p">;</span></div><div class="line" id="LC11"><br/></div><div class="line" id="LC12">&nbsp;&nbsp;<span class="c1">// zero BSS</span></div><div class="line" id="LC13">&nbsp;&nbsp;<span class="k">for</span><span class="p">(</span><span class="n">i</span> <span class="o">=</span> <span class="o">&amp;</span><span class="n">__bss_start</span><span class="p">;</span> <span class="n">i</span> <span class="o">&lt;</span> <span class="o">&amp;</span><span class="n">_end</span><span class="p">;</span> <span class="n">i</span><span class="o">++</span><span class="p">){</span></div><div class="line" id="LC14">&nbsp;&nbsp;&nbsp;&nbsp;<span class="o">*</span><span class="n">i</span> <span class="o">=</span> <span class="mi">0</span><span class="p">;</span> </div><div class="line" id="LC15">&nbsp;&nbsp;<span class="p">}</span> </div><div class="line" id="LC16"><br/></div><div class="line" id="LC17"><br/></div><div class="line" id="LC18">&nbsp;&nbsp;<span class="c1">// XXX: get argc and argv</span></div><div class="line" id="LC19"><br/></div><div class="line" id="LC20"><br/></div><div class="line" id="LC21">&nbsp;&nbsp;<span class="n">exit</span><span class="p">(</span><span class="n">main</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span><span class="mi">0</span><span class="p">,</span> <span class="n">__env</span><span class="p">));</span></div><div class="line" id="LC22"><span class="p">}</span></div><div class="line" id="LC23"><br/></div><div class="line" id="LC24"><br/></div></pre></div>
            
          </td>
        </tr>
      </table>
    
  </div>


      </div>
    </div>

  


    </div>
  
      

      <div class="push"></div>
    </div>

    <div id="footer">
      <div class="site">
        <div class="info">
          <div class="links">
            <a href="http://github.com/blog"><b>Blog</b></a> |
            <a href="http://support.github.com/">Support</a> |
            <a href="http://github.com/training">Training</a> |
            <a href="http://github.com/contact">Contact</a> |
            <a href="http://develop.github.com">API</a> |
            <a href="http://status.github.com">Status</a> |
            <a href="http://twitter.com/github">Twitter</a> |
            <a href="http://help.github.com">Help</a> |
            <a href="http://github.com/security">Security</a>
          </div>
          <div class="company">
            &copy;
            2010
            <span id="_rrt" title="0.08973s from fe2.rs.github.com">GitHub</span> Inc.
            All rights reserved. |
            <a href="/site/terms">Terms of Service</a> |
            <a href="/site/privacy">Privacy Policy</a>
          </div>
        </div>
        <div class="sponsor">
          <div>
            Powered by the <a href="http://www.rackspace.com ">Dedicated
            Servers</a> and<br/> <a href="http://www.rackspacecloud.com">Cloud
            Computing</a> of Rackspace Hosting<span>&reg;</span>
          </div>
          <a href="http://www.rackspace.com">
            <img alt="Dedicated Server" src="http://assets1.github.com/images/modules/footer/rackspace_logo.png?61a0c4b07053d81e8bf8dca46007523a0a8e6000" />
          </a>
        </div>
      </div>
    </div>

    <script>window._auth_token = "ed433012db2352fe8469b1a4e9fd90279a8aff8e"</script>
    
    
  </body>
</html>


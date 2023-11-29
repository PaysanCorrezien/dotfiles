# Load settings configured via the GUI
import catppuccin
config.load_autoconfig()

# Remap Alt 
config.bind('<Ctrl-1>', 'tab-focus 1')
config.bind('<Ctrl-2>', 'tab-focus 2')
config.bind('<Ctrl-3>', 'tab-focus 3')
config.bind('<Ctrl-4>', 'tab-focus 4')
config.bind('<Ctrl-5>', 'tab-focus 5')
config.bind('<Ctrl-6>', 'tab-focus 6')
config.bind('<Ctrl-7>', 'tab-focus 7')
config.bind('<Ctrl-8>', 'tab-focus 8')
config.bind('<Ctrl-9>', 'tab-focus 9')
config.unbind('<Alt-1>')
config.unbind('<Alt-2>')
config.unbind('<Alt-3>')
config.unbind('<Alt-4>')
config.unbind('<Alt-5>')
config.unbind('<Alt-6>')
config.unbind('<Alt-7>')
config.unbind('<Alt-8>')
config.unbind('<Alt-9>')


# Bind 'Ctrl+n' for the next command in command history
config.bind('<Ctrl-n>', 'completion-item-focus next', mode='command')

# Bind 'Ctrl+p' for the previous command in command history
config.bind('<Ctrl-p>', 'completion-item-focus prev', mode='command')

# Set the font size for tab labels
c.fonts.tabs.selected = '12pt'
c.fonts.tabs.unselected = '12pt'

catppuccin.setup(c, 'mocha', True)
# Disable third-party cookies
# config.content.cookies.accept = 'no-3rdparty'

# Set the default search engine to DuckDuckGo
c.url.searchengines['DEFAULT'] = 'https://www.duckduckgo.com/?q={}'

# Add a search engine keyword for Google
c.url.searchengines['g'] = 'https://www.google.com/search?q={}'

c.url.searchengines['y'] = 'https://www.youtube.com/results?search_query={}'

# Add a search engine keyword for GitHub
c.url.searchengines['gh'] = 'https://github.com/search?q={}'


# Bind 'Ctrl+b' to open the bookmarks
c.bindings.commands['normal']['<Ctrl-b>'] = 'cmd-set-text -s :bookmark-load'

# Bind 'Ctrl+h' to open history
c.bindings.commands['normal']['<Ctrl-h>'] = 'cmd-set-text -s :history'

# Auto-save session on exit
c.auto_save.session = True

c.content.autoplay = False

## In v2.0.0+, use next if you use Adblock Plus AND hosts blocking 
c.content.blocking.method = 'both'

c.content.default_encoding = 'utf-8'

c.content.geolocation = False

## Display PDFs within qutebrowser
c.content.pdfjs = True

c.scrolling.bar = 'always'
# c.content.cookies.accept = 'never'
c.content.cookies.accept="no-3rdparty"

c.aliases['safe-browsing'] = 'set content.blocking.enabled true ;; set content.cookies.accept no-3rdparty ;; set content.webrtc_ip_handling_policy default-public-interface-only'
c.aliases['unsafe-browsing'] = 'set content.blocking.enabled false ;; set content.cookies.accept all ;; set content.webrtc_ip_handling_policy all-interfaces'
# Set a custom user agent
# Set a recent user agent for Google Chrome on Windows
# c.content.headers.user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36'

# Disable WebRTC to prevent IP leaks
c.content.webrtc_ip_handling_policy = 'default-public-interface-only'

c.content.javascript.clipboard="access"

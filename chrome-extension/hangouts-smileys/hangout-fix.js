$(document).ready(function() {
	var shift = false;
	$(document).keydown(function(ev) {
		if (ev.which == 16)
			shift = true;
		if (ev.which == 13 && !shift) {
			var map = {
				'600': ':D',
				'603': ':)',
				'609': ';)',
				'610': ':|',
				'611': '-_-',
				'615': ':/',
				'617': ':*',
				'61b': ':P',
				'61c': ';P',
				'61e': ':(',
				'64c': '\\o/',
			};

			var str = $('div.PM .editable').html();
			for (var key in map) {
				str = str.replace(new RegExp('<img src="//ssl.gstatic.com/chat/emoji/4/emoji_u1f' + key + '.png" [^>]+>', 'g'), map[key]);
			}
			$('div.PM .editable').html(str);
		}
	});
	$(document).keyup(function(ev) {
		if (ev.which == 16)
			shift = false;
	});
});

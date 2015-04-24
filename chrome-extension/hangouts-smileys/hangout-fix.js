$(document).ready(function() {
	var shift = false;
	$(document).keydown(function(ev) {
		if (ev.which == 16)
			shift = true;
		if (ev.which == 13 && !shift) {
			var map = {
				'u1f600': ':D',
				'u263a': ':)',
				'u1f609': ';)',
				'u1f610': ':|',
				'u1f611': '-_-',
				'u1f615': ':/',
				'u1f617': ':*',
				'u1f61b': ':P',
				'u1f61c': ';P',
				'u1f61e': ':(',
				'u1f626': 'D:',
				'u1f62e': ':o',
				'u1f632': ':O',
				'u1f64c': '\\o/',
			};

			var str = $('div.PM .editable').html();
			for (var key in map) {
				str = str.replace(new RegExp('<img src="//ssl.gstatic.com/chat/emoji/.?/emoji_' + key + '.png" [^>]+>', 'g'), map[key]);
			}
			$('div.PM .editable').html(str);
		}
	});
	$(document).keyup(function(ev) {
		if (ev.which == 16)
			shift = false;
	});
});

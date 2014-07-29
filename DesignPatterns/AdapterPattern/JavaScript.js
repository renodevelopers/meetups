/* Legacy interface */
var Book = function() {}
Book.prototype.open = function() { return 'open'; }
Book.prototype.turnPage = function() { return 'turn page'; }

/* New interface */
var eBook = function() {}
eBook.prototype.pressStart = function() { return 'press start'; }
eBook.prototype.pressNext = function() { return 'press next'; }


/* Adapter for Legacy -> New */
var Adapter = function(device) {
	this.device = device;
}

Adapter.prototype.open = function() {
	return this.device.pressStart();
}

Adapter.prototype.turnPage = function() {
	return this.device.pressNext();
}

/* Tests */
if(require.main === module) {
	function assert_equal(a,b) { return a == b; }

	var kindle = new eBook();
	var kindleBook = new Adapter(kindle);

	console.log(assert_equal(kindleBook.open(), kindle.pressStart()));
	console.log(assert_equal(kindleBook.turnPage(), kindle.pressNext()));
}

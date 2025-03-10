class helper.Console {
	function Console(debugText) {
		this.stack = [];
		if (debugText) {
			this.debugText = debugText;
			this.debugText.backgroundColor = 0xffffee;
			this.debugText.borderColor = 0xff0000;
			this.debugText.text = "";
		}
	}
	function log(msg) {
		this.stack.push(msg);
		if (this.debugText) {
			this.debugText.text = this.stack.join("\n");
		}
	}
}
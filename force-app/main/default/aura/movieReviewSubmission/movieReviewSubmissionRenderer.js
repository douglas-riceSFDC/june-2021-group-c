({ 
    afterRender: function(component, helper) { 
        var svg = component.find("svg_content");
        var colorOff = component.get("v.colorOff");
        var stroke = component.get("v.stroke");
        var strokeWidth = component.get("v.strokeWidth");
        var value = svg.getElement().innerText; 
        value = value.replace(/#999999/g, colorOff); 
        value = value.replace(/999/g, strokeWidth); 
        value = value.replace(/#888888/g, stroke); 
        svg.getElement().innerHTML = value;
	}
})
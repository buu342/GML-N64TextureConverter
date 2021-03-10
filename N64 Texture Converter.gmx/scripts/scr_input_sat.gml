global.alphasat = round(min(255, real(argument[1])))
self.text = string(global.alphasat)
event_perform_object(obj_colorpicker, ev_other, ev_user0);

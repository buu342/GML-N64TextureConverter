global.alphahue = round(min(255, real(argument[1])))
self.text = string(global.alphahue)
event_perform_object(obj_colorpicker, ev_other, ev_user0);

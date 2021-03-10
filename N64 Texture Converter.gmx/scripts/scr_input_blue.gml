obj_colorpicker.colb = round(max(0, min(255, real(argument[1]))))
self.text = string(obj_colorpicker.colb)
event_perform_object(obj_colorpicker, ev_other, ev_user1);
event_perform_object(obj_colorpicker, ev_other, ev_user0);

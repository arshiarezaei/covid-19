classdef queue_array < handle
  properties ( Access = public )
    elems = zeros(1,1);
    first = 0;
    last = 0;
  end
  methods
    function this = Queue()
    end
    function push(this,elem)
      this.last = this.last+1;
      this.elems(this.last) = elem;
    end
    function ret = empty(this)
      if(this.last-this.first == 0)
          ret = 1;
      else
          ret = 0;
      end
    end
    function elem = front(this)
      if this.empty()
        elem = 0;
      end
      elem = this.elems(this.first+1);
    end
    function elem = back(this)
      if (this.empty() == 1)
        elem = 0;
      else
      elem = this.elems(this.last);
      end
    end
    function elem = size(this)
      elem = this.last - this.first;
    end
    function pop(this)
      this.first = this.first + 1;
      if (this.last-this.first)<0.25*numel(this.elems)
        this.elems = this.elems(this.first+1:this.last);
        this.first = 0;
        this.last = numel(this.elems); 
      end
    end
  end
end

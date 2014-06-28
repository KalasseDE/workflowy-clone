Workflowy.Views.Show = Backbone.View.extend({
  template: JST['items/show'],

  initialize: function() {
    this.sublist = new Workflowy.Views.List({
      collection: this.model.children()
    });

    this.listenTo(this.model, 'change', this.render);
  },

  render: function() {
    var html = this.template({
      item: this.model,
      breadcrumbs: this.breadcrumbs()
    });

    this.$el.html(html);
    this.$el.find('article').html(this.sublist.render().$el);

    return this;
  },

  remove: function() {
    this.sublist.remove();
    return Backbone.View.prototype.remove.apply(this, arguments);
  },

  breadcrumbs: function() {
    var breadcrumbs = [];
    var item = this.model;

    while (item) {
      item = Workflowy.lookup.id[item.get('parent_id')];
      if (item) {
        breadcrumbs.unshift(item.aTag());
      } else {
        breadcrumbs.unshift('<a href="#">Home</a>');
      }
    }

    return breadcrumbs.join(' > ');
  }
});

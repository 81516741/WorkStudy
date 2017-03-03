//定义一个已经存在的class
defineClass("TableViewController", {
            
            //若方法存在就替换 没有就生成
            tableView_didSelectRowAtIndexPath: function(tableView, indexPath) {
            self.opertaion(indexPath)
            },
            
            opertaion:function(indexPath){
            var ctrl = require('UIViewController').alloc().init()
            ctrl.view().setBackgroundColor(require('UIColor').greenColor())
            var navi = self.navi();
            console.log(navi);
            console.log(ctrl);
            console.log(self.dataSource());
            console.log(self.dataSource().length);
            if(indexPath.row() > self.dataSource().length - 1){
            return;
            }
            var content = self.dataSource()[indexPath.row()];
            console.log(content);
            ctrl.setTitle(content);
            navi.pushViewController_animated(ctrl,true);
            
            },
            tableView_cellForRowAtIndexPath: function(tableView, indexPath){
            var content = self.dataSource()[indexPath.row()];
            var cell = self.tableView().dequeueReusableCellWithIdentifier_forIndexPath("cell",indexPath);
            cell.textLabel().setText(content);
            return cell;
            },
            
            dataSource: function() {
            // get the original method by adding prefix 'ORIG'
            var data = self.ORIGdataSource().toJS();
            data.push('嘎嘎嘎');
            return data;
            }
            })

defineClass('ViewController', {
  click: function(sender) {
    var tableViewCtrl = JPTableViewController.alloc().init()
    self.navigationController().pushViewController_animated(tableViewCtrl, YES)
  }
})

defineClass('JPTableViewController : UITableViewController <UIAlertViewDelegate>', ['data'], {
  dataSource: function() {
    var data = self.data();
    if (data) return data;
    var data = [];
    for (var i = 0; i < 20; i ++) {
      data.push("cell from js " + i);
    }
    self.setData(data)
    return data;
  },
  numberOfSectionsInTableView: function(tableView) {
    return 1;
  },
  tableView_numberOfRowsInSection: function(tableView, section) {
    return self.dataSource().length;
  },
  tableView_cellForRowAtIndexPath: function(tableView, indexPath) {
    var cell = tableView.dequeueReusableCellWithIdentifier("cell") 
    if (!cell) {
      cell = require('UITableViewCell').alloc().initWithStyle_reuseIdentifier(0, "cell")
    }
    cell.textLabel().setText(self.dataSource()[indexPath.row()])
    return cell
  },
  tableView_heightForRowAtIndexPath: function(tableView, indexPath) {
    return 60
  },
  tableView_didSelectRowAtIndexPath: function(tableView, indexPath) {
     var alertView = require('UIAlertView').alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("Alert",self.dataSource()[indexPath.row()], self, "OK",  null);
     alertView.show()
  },
  alertView_willDismissWithButtonIndex: function(alertView, idx) {
    console.log('click btn ' + alertView.buttonTitleAtIndex(idx).toJS())
  }
})

const USERS_LIST_URL = "/bots/users/list";
const BOTS_LIST_URL = "/bots/list";

const submitUser = (rawData) => {
  console.log(rawData, "server response");
  $$("bots_list").load(BOTS_LIST_URL);
};

const bot_form_ui = {
  container:"form_div", //id div в котором разместится данный элемент
  view: "form",
  width: "400",
  elements: [
    {
      label: "Описание бота",
      view: "label",
    },
    {
      view: "text",
      name: "fname",
      width: 200,
      placeholder: "укажите название бота",
      label: "Название",
      labelPosition: "top",
    },
    {
      view: "richselect",
      width: 200,
      name: "fowner",
      options: USERS_LIST_URL,
      label: "Владелец",
      labelPosition: "top",
    },
    {
      label: "Сохранить",
      view: "button",
      width: 240,
      click: function () {
        var values = this.getFormView().getValues();
        console.log(values, "form values");
        webix.ajax().post("/bots/save", values, submitUser);
      },
    },
  ],
};

const bots_table_ui = {
    id: "bots_list",
    view:"datatable", //https://docs.webix.com/api__refs__ui.datatable.html
    container: "users_list_div",
    columns:[
        { id:"name",    header:"Бот",              width:250},
        { id:"ownername",   header:"Владелец",    width:200}
    ],
    url: BOTS_LIST_URL
}

webix.ready(function () {
  webix.ui(bot_form_ui);
  webix.ui(bots_table_ui);
});

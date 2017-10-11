using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Linq.Expressions;
using System.Reflection;

namespace tBOT.Services.ExtentionMethods
{
    public static class LinqExtensions
    {
        public static DataTable ToPivotTable<T, TColumn, TRow, TData>(
        this IEnumerable<T> source,
        Func<T, TColumn> columnSelector,
        Expression<Func<T, TRow>> rowSelector,
        Func<IEnumerable<T>, TData> dataSelector,
        bool includeKey=true,
        string extraColumn=null            
            )
        {
            DataTable table = new DataTable();
            var rowSelectorName = ((MemberExpression)rowSelector.Body).Member.Name;            
            if (includeKey) { table.Columns.Add(new DataColumn(rowSelectorName)); }          
            if (!string.IsNullOrEmpty(extraColumn)){ table.Columns.Add(new DataColumn(extraColumn)); }
            var columns = source.Select(columnSelector).Distinct();
            string clmn;

            foreach (var column in columns)
            {
                clmn = column == null ? "Null" : column.ToString();               
                table.Columns.Add(new DataColumn(clmn));
            }

            var rows = source.GroupBy(rowSelector.Compile())            
            .Select(rowGroup => new {
                    Key = rowGroup.Key,
                    Values = columns.GroupJoin(
                        rowGroup,
                        c => c,
                        r => columnSelector(r),
                        (c, columnGroup) => dataSelector(columnGroup))
                    });

            
            foreach (var row in rows)
            {
                dynamic valueExtraColumn = null;
                if (!string.IsNullOrEmpty(extraColumn))
                {                    
                    foreach (dynamic item in source)
                    {
                        var valueRowSelector = item.GetType().GetProperty(rowSelectorName).GetValue(item, null);                        
                        if (valueRowSelector == row.Key)
                        {
                            valueExtraColumn = item.GetType().GetProperty(extraColumn).GetValue(item, null);
                            break;
                        }
                    }

                }
                var dataRow = table.NewRow();
                    var items = row.Values.Cast<object>().ToList();
                if (!string.IsNullOrEmpty(extraColumn)) { items.Insert(0, valueExtraColumn); }
                if (includeKey) { items.Insert(0, row.Key); }
                dataRow.ItemArray = items.ToArray();
                    table.Rows.Add(dataRow);
            }

            return table;
        }


    }
}